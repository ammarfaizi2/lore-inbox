Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287750AbSANR1M>; Mon, 14 Jan 2002 12:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSANR1D>; Mon, 14 Jan 2002 12:27:03 -0500
Received: from ns.suse.de ([213.95.15.193]:64780 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287750AbSANR05>;
	Mon, 14 Jan 2002 12:26:57 -0500
Date: Mon, 14 Jan 2002 18:26:56 +0100
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: slowdown with new scheduler.
Message-ID: <20020114182656.G15139@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20020114124541.A32412@suse.de> <20020114172010.GA173@elfie.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114172010.GA173@elfie.cavy.de>; from hd@cavy.de on Mon, Jan 14, 2002 at 06:20:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:20:10PM +0100, Heinz Diehl wrote:
 > I did the same; same config, fresh tree, reboot between the test. 
 > The machine is a (single-processor) AMD K6-2/400 with 256 MB RAM.
 > Here are the results:
 > ... <deletia>
 > Ingo's scheduler rocks, it runs like hell (and is absolutely stable here)  ;)

 The issue seems to be when a process like dnetc is running
 (which runs at +19 iirc), it seems to be getting scheduled way too
 often.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
