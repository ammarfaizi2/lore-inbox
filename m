Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSBKMGW>; Mon, 11 Feb 2002 07:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288736AbSBKMGN>; Mon, 11 Feb 2002 07:06:13 -0500
Received: from ns.suse.de ([213.95.15.193]:30219 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288614AbSBKMGA>;
	Mon, 11 Feb 2002 07:06:00 -0500
Date: Mon, 11 Feb 2002 13:05:57 +0100
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager
Message-ID: <20020211130557.A4285@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202081825.g18IPSf03107@localhost.localdomain> <20020211090021.GA8012@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211090021.GA8012@pazke.ipt>; from pazke@orbita1.ru on Mon, Feb 11, 2002 at 12:00:21PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 12:00:21PM +0300, Andrey Panin wrote:

 > if [ "$CONFIG_VISWS" != "y" ]; then
 >    bool 'MCA support' CONFIG_MCA
 >    if [ "$CONFIG_MCA" = "y" ]; then
 > 	bool '   Support for the NCR Voyager Architecture' CONFIG_VOYAGER
 > 
 > How MCA and NCR Voyager support related to SGI Visual Workstations support
 > (CONFIG_VISWS) ?

 It is kinda horrible. What I parsed it as is VISWS and Voyager
 are mutually exclusive, both have MCA available, but Voyager
 is a 'must have' case.

 icky.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
