Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311763AbSCTQRY>; Wed, 20 Mar 2002 11:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311761AbSCTQRP>; Wed, 20 Mar 2002 11:17:15 -0500
Received: from ns.suse.de ([213.95.15.193]:55826 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311756AbSCTQQ4>;
	Wed, 20 Mar 2002 11:16:56 -0500
Date: Wed, 20 Mar 2002 17:16:55 +0100
From: Dave Jones <davej@suse.de>
To: Manon Goo <manon@manon.de>
Cc: "White, Charles" <Charles.White@COMPAQ.com>, Arrays <Arrays@COMPAQ.com>,
        linux-kernel@vger.kernel.org,
        Markus =?iso-8859-1?Q?Schr=F6der?= <schroeder.markus@allianz.de>
Subject: Re: Hooks for random device entropy generation missing in cpqarray.c
Message-ID: <20020320171655.F5094@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Manon Goo <manon@manon.de>,
	"White, Charles" <Charles.White@COMPAQ.com>,
	Arrays <Arrays@COMPAQ.com>, linux-kernel@vger.kernel.org,
	Markus =?iso-8859-1?Q?Schr=F6der?= <schroeder.markus@allianz.de>
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB01E88B79@cceexc18.americas.cpqc <5013428.1016644014@eva.dhcp.gimlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 05:06:54PM +0100, Manon Goo wrote:
 > I have a quick and drity patch for 1 contorlller:
 > ...
 >
 > --On Mittwoch, 20. März 2002 8:25 Uhr -0600 "White, Charles" 
 > <Charles.White@COMPAQ.com> wrote:
 > 
 > >Yes.. I was reported that it some how got dropped from our 2.4 version of
 > >the driver..  DON'T add add_interrupt_randomness, just add "|
 > >SA_SAMPLE_RANDOM" to the call to request_irq.
 > How would I do this for the cpqarray ?

 Exactly like Charles explained how to. See also...
 http://www.codemonkey.org.uk/patches/merged/2.5.4/dj2/random-cpqirq.diff
 if it still isnt' clear.
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
