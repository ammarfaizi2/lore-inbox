Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVJJVhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVJJVhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVJJVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:37:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52117 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751247AbVJJVhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:37:48 -0400
Date: Mon, 10 Oct 2005 22:37:48 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010213748.GQ7992@ftp.linux.org.uk>
References: <20051010171052.GL22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010171052.GL22483@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> There are a variety of mount options, tunable parameters, internal
> statistics, and methods of online file system manipulation.

Could you explain WTF are you doing with rename here?  This pile of
ioctls is every bit as bad as sys_reiser4(); kindly provide a detailed
description of the API you've introduced and explain why nothing saner
would do...
