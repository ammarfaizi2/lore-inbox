Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVBFViI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVBFViI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 16:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBFViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 16:38:08 -0500
Received: from main.gmane.org ([80.91.229.2]:24486 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261321AbVBFViD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 16:38:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
Date: Sun, 06 Feb 2005 15:37:46 -0600
Message-ID: <cu62l6$939$1@sea.gmane.org>
References: <9e4733910502051745c25d6f@mail.gmail.com> <20050206040526.GA2908@redhat.com> <9e4733910502052158491b5ce3@mail.gmail.com> <20050206060839.GA19330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-208.client.comcast.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
In-Reply-To: <20050206060839.GA19330@redhat.com>
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Another way forward (somewhat hacky in one sense, but a lot cleaner in another)
> would be to change the PCI code so that it'll load and init
> multiple drivers that claim to support the same PCI ID.
> This may cause issues for some other drivers however where
> we have an old and a new driver with ID overlap.

This sounds like it would allow the use of the parallel ATA interfaces
on SATA controllers, which would make a lot of people happy.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

