Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290104AbSAORd1>; Tue, 15 Jan 2002 12:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290109AbSAORdS>; Tue, 15 Jan 2002 12:33:18 -0500
Received: from ns.suse.de ([213.95.15.193]:8971 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290104AbSAORdO>;
	Tue, 15 Jan 2002 12:33:14 -0500
Date: Tue, 15 Jan 2002 18:33:12 +0100
From: Dave Jones <davej@suse.de>
To: Craig Whitmore <lennon@orcon.net.nz>
Cc: A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: atyfb in 2.5.2
Message-ID: <20020115183312.B32088@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Craig Whitmore <lennon@orcon.net.nz>,
	A Guy Called Tyketto <tyketto@wizard.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020115094953.GA24170@wizard.com> <002001c19dac$6a34de70$0100000a@orcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002001c19dac$6a34de70$0100000a@orcon.net>; from lennon@orcon.net.nz on Tue, Jan 15, 2002 at 11:06:52PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I get the same for the rivafb as well (looks like all the fb stuff actually)
 >    info->node = -1;
 > commenting out that line made it so it compiled and worked (well looked like
 > it did when using it , but may not be 100% right )
 > Can anyone got a proper fix for this?

 info->node = NODEV;

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
