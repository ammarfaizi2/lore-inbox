Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHGVA2>; Wed, 7 Aug 2002 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHGVA2>; Wed, 7 Aug 2002 17:00:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37339 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293203AbSHGU7q>;
	Wed, 7 Aug 2002 16:59:46 -0400
Date: Wed, 07 Aug 2002 13:50:38 -0700 (PDT)
Message-Id: <20020807.135038.57454567.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buglet in irq compat code in 2.5.30
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020807165443.A3730@devserv.devel.redhat.com>
References: <20020807165443.A3730@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Wed, 7 Aug 2002 16:54:43 -0400

   The save_flags used to save flags, while local_irq_save saves AND
   closes interrupts, and local_irq_save_off simply does not exist.
   I did not see anything on the list, perhaps nobody is bold enough
   to use 2.5.30?
   
These things really will die very soon, probably best not
to rely on them at all :-)
