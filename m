Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVC3Pin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVC3Pin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVC3Pin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:38:43 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:24271 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262248AbVC3Pim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:38:42 -0500
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Subject: Re: Disable cache disk
Date: Wed, 30 Mar 2005 17:38:39 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <424AA2F0.3090100@wanadoo.fr>
In-Reply-To: <424AA2F0.3090100@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301738.39057.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 15:00, Yves Crespin wrote:
> 1/ is-it possible to *really* be synchronize. I prefer to have a blocked
> write() than use cache and get swap!

Try to mount with the sync option. 

> 2/ is-it possible to disable cache disk ?

your copy tool has to support/use O_DIRECT
