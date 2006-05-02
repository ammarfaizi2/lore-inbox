Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWEBAW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEBAW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEBAW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:22:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27837 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932331AbWEBAW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:22:28 -0400
Date: Tue, 2 May 2006 01:22:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: Andrew Morton <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/bio.c: initialize variable, remove warning
Message-ID: <20060502002223.GR27946@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0605012353100.5245@joo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605012353100.5245@joo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 11:55:27PM +0300, Petri T. Koistinen wrote:
> From: Petri T. Koistinen <petri.koistinen@iki.fi>
> 
> Remove compiler warning by initializing uninitialized variable.

NAK.  Unless you can show the path where it is used uninitialized,
such patches should not go in.
