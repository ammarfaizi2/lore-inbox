Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUKOKZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUKOKZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKOKZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:25:49 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:3565 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbUKOKZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:25:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OSLN/70S3uGudFV5D5LMtaTuBVOlA4L2C8GoGj88/HLMb5zW/XJL/oR6sVMwbJy3snAa6bPAG+pQ3eZU4h2fzIC7h6cp5f3yDIi5PPKvfhRr/wnjXdQ//mXk6Z9cU+5IP14s3cXoD9IK7gr/6U13yOfX1mR3XYfCyuNCHJaHiaE=
Message-ID: <84144f0204111502256c8af8b8@mail.gmail.com>
Date: Mon, 15 Nov 2004 12:25:44 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Jan Beulich <jbeulich@novell.com>
Subject: Re: logo_shown check in fbcon_scoll
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s19348d4.015@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <s19348d4.015@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004 12:01:29 +0100, Jan Beulich <jbeulich@novell.com> wrote:
> Wouldn't it seem reasonable that the logo_shown check in the SM_UP case
> should similarly be done in the SM_DOWN case?

Yes, but I don't think you can hit that bug in practice. You cannot
scroll up when the logo is visible.

                            Pekka
