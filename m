Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWDQOiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWDQOiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDQOiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:38:08 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9913 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751004AbWDQOiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:38:07 -0400
Subject: Re: [RFC] binary firmware and modules
From: Marcel Holtmann <marcel@holtmann.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Oliver Neukum <oliver@neukum.org>, Jon Masters <jcm@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145284193.2847.53.camel@laptopd505.fenrus.org>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604151154.22787.oliver@neukum.org>
	 <20060417142214.GI5042@tuxdriver.com>
	 <1145284193.2847.53.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 16:38:12 +0200
Message-Id: <1145284692.26498.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> > > compiled drivers need their firmware, too. Secondly, do all drivers
> > > know at compile time which firmware they'll need?
> > 
> > They have to know what they will request, do they not?
> 
> in order to not fall in the naming-policy trap: do we need a translation
> layer here? eg the module asks for firmware-<modulename>
> and userspace then somehow maps that to a full filename via a lookup
> table?

why do we need that? Currently it is not needed and I don't see a reason
to make it more complicated.

The important thing is to export the used firmware names to the
userspace, because this piece of information is only stored inside the
kernel source code right now.

Regards

Marcel


