Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752256AbWFMDZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbWFMDZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWFMDZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:25:52 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:6031 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1752183AbWFMDZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:25:51 -0400
Date: Mon, 12 Jun 2006 23:25:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Sridhar Samudrala <sri@us.ibm.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] update sunrpc to use in-kernel sockets API
In-Reply-To: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606122320010.31627@d.namei>
References: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Sridhar Samudrala wrote:

> -	sendpage = sock->ops->sendpage ? : sock_no_sendpage;
> +	sendpage = kernel_sendpage ? : sock_no_sendpage;

This is not equivalent.


-- 
James Morris
<jmorris@namei.org>
