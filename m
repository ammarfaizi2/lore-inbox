Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266212AbSKFXUy>; Wed, 6 Nov 2002 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266213AbSKFXUy>; Wed, 6 Nov 2002 18:20:54 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:7578 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S266212AbSKFXUx>; Wed, 6 Nov 2002 18:20:53 -0500
Date: Wed, 6 Nov 2002 18:27:27 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5-bk] PCI 2/3: misc fixes
In-Reply-To: <20021106210747.D686@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0211061824430.27470-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Ivan Kokshaysky wrote:

> - Use PCI_BUS_NUM_RESOURCES instead on `4' in pci_find_parent_resource;
> - clean up pci_claim_resource() and make it a bit more informative;
> - pdev_sort_resources() must be __devinit, as it's called from
>   pbus_assign_resources_sorted(), which is __devinit now.

My apologies about pdev_sort_resources, I completely missed it when I was 
pushing __devinit down from pbus_assign_resources.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

