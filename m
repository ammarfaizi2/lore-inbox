Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWAORZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWAORZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWAORZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:25:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:44975 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932102AbWAORZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:25:35 -0500
From: Andi Kleen <ak@suse.de>
To: 7eggert@gmx.de
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Sun, 15 Jan 2006 18:13:26 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <5rvok-5Sr-1@gated-at.bofh.it> <5tagc-6AZ-25@gated-at.bofh.it> <E1EyB3r-0000vP-G3@be1.lrz>
In-Reply-To: <E1EyB3r-0000vP-G3@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151813.26688.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 January 2006 17:48, Bodo Eggert wrote:
> Andi Kleen <ak@suse.de> wrote:
> 
> > (it is hard to understand that with 128MB+ graphic cards and 512+MB
> > computers the scroll back must be still so short...)
> 
> The VGA scrollback buffer is limited by the text area of the video RAM.
> The text area is in the DOS memory at 0xB800 (or 0xB000) and extends
> 32 KB (or in case of MDA, 4 KB). Each character will use 2 Bytes.
> Therefore you can store up to 16,000 characters or 4 pages of text.

It was a rhetorical question.

-Andi

