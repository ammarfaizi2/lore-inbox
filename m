Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTHYUF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTHYUF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:05:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37328 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262279AbTHYUFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:05:23 -0400
Date: Mon, 25 Aug 2003 21:05:21 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of larger dev_t
Message-ID: <20030825200521.GK454@parcelfarce.linux.theplanet.co.uk>
References: <bidp2a$hdp$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bidp2a$hdp$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 12:46:18PM -0700, H. Peter Anvin wrote:
> Since I have returned to the land of the living^Whacking...
> 
> I gather large dev_t is still not in the mainline; what is still
> required to make this happen?

bdev cleanup (unfortunately) + getting conversions in filesystem code
into sane shape.  I've got the rest...
