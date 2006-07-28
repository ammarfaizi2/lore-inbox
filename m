Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWG1DjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWG1DjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWG1DjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:39:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:59554 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751830AbWG1DjC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:39:02 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Petr Vandrovec <petr@vandrovec.name>
Subject: Re: [PATCH] ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
Date: Fri, 28 Jul 2006 05:38:53 +0200
User-Agent: KMail/1.9.1
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270745.42622.arnd.bergmann@de.ibm.com> <20060728021520.GA23831@vana.vc.cvut.cz>
In-Reply-To: <20060728021520.GA23831@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607280538.53355.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 04:15, Petr Vandrovec wrote:
> I've updated your diff as outlined above, and I've removed ncp_fs.h include from
> compat_ioctl, as it is not needed anymore.  I've also removed one 
> #include <linux/config.h> you introduced...

Ok, great! Are you pushing this for 2.6.19?

	Arnd <><
