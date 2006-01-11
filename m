Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWAKSYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWAKSYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAKSYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:24:10 -0500
Received: from mta01.mail.tds.net ([216.170.230.81]:45463 "EHLO
	mta01.mail.tds.net") by vger.kernel.org with ESMTP id S932435AbWAKSYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:24:09 -0500
Date: Wed, 11 Jan 2006 12:23:44 -0600 (CST)
From: David Lloyd <dmlloyd@tds.net>
To: Kenny Simpson <theonetruekenny@yahoo.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is user-space AIO dead?
In-Reply-To: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0601111223210.14191@tomservo.workpc.tds.net>
References: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Kenny Simpson wrote:

> Hi,
>  Having read the excellent paper by IBM presented at the 2003 OLS about Asynchronous I/O Support
> in Linux 2.5, I found the conclusion rather disappointing:
> "In conclusion, there appears to be no conditions for raw or O_DIRECT access under which AIO can
> show a noticable benefit." - p385.
> http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Pulavarty-OLS2003.pdf
>
> Is this still the case?
>
> If I want a transactional engine (like a database) that needs to persist to stable storage, is it
> still best to use a helper thread to do write/fsync or O_SYNC|O_DIRECT?

Wouldn't nonblocking I/O on regular files be nice?

- D
