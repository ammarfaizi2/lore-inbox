Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbTIKV6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTIKV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:58:42 -0400
Received: from aneto.able.es ([212.97.163.22]:61394 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261583AbTIKV6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:58:10 -0400
Date: Thu, 11 Sep 2003 23:58:05 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jamie Lokier <jamie@shareable.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Message-ID: <20030911215805.GA7221@werewolf.able.es>
References: <200309111540.58729@bilbo.math.uni-mannheim.de> <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk> <20030911170944.GG29532@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030911170944.GG29532@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Sep 11, 2003 at 19:09:44 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.11, Jamie Lokier wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Bad choice of name - too easy to confuse with kmalloc().
> 
> kmalloc_and_zero() would be much clearer.
> 

Why not kcalloc() ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
