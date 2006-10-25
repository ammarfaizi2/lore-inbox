Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423387AbWJYMat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423387AbWJYMat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbWJYMat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:30:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:12999 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423386AbWJYMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:30:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 11/16] sysfs: add support for adding/removing spu sysfs attributes
Date: Wed, 25 Oct 2006 14:27:18 +0200
User-Agent: KMail/1.9.5
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       Christian Krafft <krafft@de.ibm.com>
References: <20061024163113.694643000@arndb.de> <20061024163816.460479000@arndb.de> <20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251427.20039.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 09:52, Heiko Carstens wrote:
> You probably should check for errors on sysdev_create_file, clean up and
> return an error number instead of always 0.
> This is true for all the new functions here.

Right, thanks for the review.

Christian or I will take care of this.

	Arnd <><
