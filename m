Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTFROKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFROKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:10:13 -0400
Received: from granite.he.net ([216.218.226.66]:28676 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265226AbTFROJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:09:28 -0400
Date: Wed, 18 Jun 2003 07:22:07 -0700
From: Greg KH <greg@kroah.com>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
Message-ID: <20030618142206.GA16055@kroah.com>
References: <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de> <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de> <5.1.0.14.2.20030618141052.00af0b50@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030618141052.00af0b50@pop.t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 02:18:51PM +0200, Margit Schubert-While wrote:
> The lm85, adm1021 patches also apply cleanly to 2.5.72 :-)

Yes, I have them in a bk tree and will be sending them to Linus later
today :)

> Question to Greg, Philip :
> Is there really a race conditon with the update function ?

Where do you think the race is?

> If so, all sensors are incorrect (also in CVS lmsensors).
> Comments ?
> 
> Is any thought being given to merging ACPI and sensors ?

The way we report the sensor values to userspace, yes, I have talked
with the acpi people about this in the past.  But it looks like a 2.7
thing at the earliest.

thanks,

greg k-h
