Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVIXGJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVIXGJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 02:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIXGJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 02:09:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50405 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751442AbVIXGJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 02:09:14 -0400
Date: Sat, 24 Sep 2005 07:09:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
Message-ID: <20050924060913.GK7992@ftp.linux.org.uk>
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org> <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 07:52:06AM +0200, Miklos Szeredi wrote:
> Well yes.  But I don't think anybody is using it, and if so they are
> clearly breaking the rules in man open(2):

Be liberal in what you accept and all such...  Everything else aside,
why bother?  This check doesn't buy you anything.
