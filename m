Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVASXjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVASXjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVASXjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:39:01 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:30710 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261984AbVASXhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:37:40 -0500
Date: Wed, 19 Jan 2005 15:37:13 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] I2C: Kill i2c_client.id
Message-ID: <20050119233713.GA6178@kroah.com>
References: <20050116194653.17c96499.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 07:46:53PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> As discussed earlier on the LKML [1], here comes a patch set killing the
> id member of the i2c_client structure. Let me recap my main reasons for
> doing so:

I've applied all 5 patches, and then just deleted the field altogether
(mainly because sparse complained about it, and there's no reason to
have it around anymore.)

thanks for doing this work, it was really needed.

greg k-h
