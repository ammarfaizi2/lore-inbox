Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCYH10>; Tue, 25 Mar 2003 02:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCYH10>; Tue, 25 Mar 2003 02:27:26 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:13834 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261608AbTCYH10>; Tue, 25 Mar 2003 02:27:26 -0500
Date: Tue, 25 Mar 2003 07:38:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: How to convert i2c adapter drivers into good kernel code
Message-ID: <20030325073834.B30897@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@Stimpy.netroedge.com
References: <20030325072511.GD12590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030325072511.GD12590@kroah.com>; from greg@kroah.com on Mon, Mar 24, 2003 at 11:25:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 11:25:12PM -0800, Greg KH wrote:
>    line in the driver, and replace the LM_VERSION and LM_DATE entries
>    with I2C_VERSION and I2C_DATE to fix that compile time error.

That's bogus.  Replace LM_VERSION with the lm_sensors version you took it
from + lk1 (e.g. "2.7.0-lk1) and LM_DATE with your modification date.
Or just remove them altogether..

