Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUJUJWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUJUJWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268978AbUJUJVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:21:43 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:30087 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S269029AbUJUJUo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:20:44 -0400
Subject: Re: [patch 2.6.9 0/11] Add MODULE_VERSION to several network
	drivers
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com,
       greearb@candelatech.com
In-Reply-To: <20041020141146.C8775@tuxdriver.com>
References: <20041020141146.C8775@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098350269.2810.17.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 11:17:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 20:11, John W. Linville wrote:
> Patches to add MODULE_VERSION lines to several network drivers...
> 
> Here is the list:

have you checked if the version of these drivers is actually useful? (eg
updated when the driver changes) If it's not I'd say adding a
MODULE_VERSION to it makes no sense whatsoever.
