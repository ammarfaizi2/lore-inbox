Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTI2SHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbTI2SFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:05:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31617 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264106AbTI2SDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:03:13 -0400
Date: Mon, 29 Sep 2003 19:03:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jean-Guillaume <jean-guillaume.paradis@ericsson.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple Procfs question: Triggering an "action" when opening a directory instead of a file (with seqfile.h)???
Message-ID: <20030929180310.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <3F786E73.6010306@ericsson.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F786E73.6010306@ericsson.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:40:03PM -0400, Jean-Guillaume wrote:
> Hello everybody :)
 
> I need some help on this one, I couldn't find anything on google or in 
> the archives of the mailing list. Here it goes:
> 
> I want to trigger an action when "opening" a directory of the procfs. 
> This is easy for files, but how is it done for directories...???

With a separate filesystem.  Don't do that on procfs, it's messy enough as
it is.
