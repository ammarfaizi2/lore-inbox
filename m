Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUKJAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUKJAUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUKJAUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:20:14 -0500
Received: from smtp812.mail.ukl.yahoo.com ([217.12.12.202]:16221 "HELO
	smtp812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261801AbUKJAT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:19:58 -0500
From: Nick Sanders <sandersn@btinternet.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Problem burning Audio CDs
Date: Wed, 10 Nov 2004 00:20:24 +0000
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200411061049.38278.sandersn@btinternet.com> <41915C71.9090609@tmr.com>
In-Reply-To: <41915C71.9090609@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411100020.24781.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 00:10, Bill Davidsen wrote:
> Nick Sanders wrote:
> > Hi,
> >
> > I've got problem with burning audio cds using k3b with 2.6.9 onwards. It
> > gets about 22% through and then cdrecord hangs saying '/usr/bin/cdrecord:
> > Caught interrupt.'
> >
> > 2.6.7 works fine and I couldn't test 2.6.8.
> >
> > I noticed that the CPU usage is alot higher in the caes where it fails
> >
> > Buring data CDs and DVDs works fine.
> >
> > I have also just noticed audio cd ripping doesn't work.
> >
> > Has anyone else had this problem?
>
> Are you going direct or using ide-scsi?

it's using ide-cd (compiled in) I haven't tried with ide-scsi. It seems that 
without the cdrecord option '-text' it doesn't hang.
