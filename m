Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUKFRck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUKFRck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUKFRck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:32:40 -0500
Received: from smtp810.mail.ukl.yahoo.com ([217.12.12.200]:58796 "HELO
	smtp810.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261428AbUKFRcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:32:39 -0500
From: Nick Sanders <sandersn@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem burning Audio CDs
Date: Sat, 6 Nov 2004 17:33:08 +0000
User-Agent: KMail/1.7
References: <200411061049.38278.sandersn@btinternet.com>
In-Reply-To: <200411061049.38278.sandersn@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411061733.08569.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 November 2004 10:49, Nick Sanders wrote:
> Hi,
>
> I've got problem with burning audio cds using k3b with 2.6.9 onwards. It
> gets about 22% through and then cdrecord hangs saying '/usr/bin/cdrecord:
> Caught interrupt.'
>
> 2.6.7 works fine and I couldn't test 2.6.8.
>

On further investigation it is the cdrecord option '-text' that causes the 
hang (but not with 2.6.7). Any ideas?

> I noticed that the CPU usage is alot higher in the caes where it fails
>
> Buring data CDs and DVDs works fine.
>
> I have also just noticed audio cd ripping doesn't work.

cd audio ripping doesn't work in 2.6.7 either the following is logged when I 
try 'kernel: cdrom: dropping to single frame dma' and cdda2wav says 
'EnableCdda_cooked (CDIOCSETCDDA) is not available...'


