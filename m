Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWHHQDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWHHQDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWHHQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:03:00 -0400
Received: from main.gmane.org ([80.91.229.2]:58041 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030184AbWHHQC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:02:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Date: 08 Aug 2006 19:02:15 +0300
Message-ID: <5dpsfbrzaw.fsf@attruh.keh.iki.fi>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <eb8g8b$837$1@taverner.cs.berkeley.edu> <20060807225642.GA31752@nevyn.them.org> <200608071813.18661.chase.venters@clientec.com> <84144f020608080516k183072efmdcc8a4dfc334b2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pekka Enberg" <penberg@cs.helsinki.fi> writes:

> On 8/8/06, Chase Venters <chase.venters@clientec.com> wrote:
> > IIRC, it returns EBADF because the file actually gets closed. The file
> > descriptor, on the other hand, is permanently leaked.
> >
> > Have these details changed?
> 
> No. Your description is accurate.
> 
>                                              Pekka

So application can not close() it and recover file description?

/ Kari Hurtta

