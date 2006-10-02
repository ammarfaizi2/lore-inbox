Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWJBQvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWJBQvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWJBQvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:51:04 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:7839 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S932357AbWJBQu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:50:59 -0400
Date: Mon, 2 Oct 2006 18:50:53 +0200
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Okt 2006, Norbert Preining wrote:
> > The main features of the latest beta is WE-21 support (long/short
> > retry, power saving level, modulation), enhanced command line parser
> > in iwconfig, scanning options, more WPA support and more footprint
> > reduction tricks
> 
> Bingo. I build the new 29-pre10 and everything is working.

Sorry, that was over-optimistic. still same behaviour as with the Debian
v28 version.

The last character is cut of from wpa_supplicant. I have to set the
essid by hadn with
	"real-essid "
mark the space at the end!

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
MELCOMBE REGIS (n.)
The name of the style of decoration used in cocktail lounges in mock
Tudor hotels in Surrey.
			--- Douglas Adams, The Meaning of Liff
