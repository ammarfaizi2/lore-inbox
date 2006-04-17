Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWDQOaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWDQOaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWDQOaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:30:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18333 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750984AbWDQOaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:30:03 -0400
Subject: Re: [RFC] binary firmware and modules
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Oliver Neukum <oliver@neukum.org>, Jon Masters <jcm@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060417142214.GI5042@tuxdriver.com>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604151154.22787.oliver@neukum.org>
	 <20060417142214.GI5042@tuxdriver.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 16:29:53 +0200
Message-Id: <1145284193.2847.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 10:22 -0400, John W. Linville wrote:
> On Sat, Apr 15, 2006 at 11:54:22AM +0200, Oliver Neukum wrote:
> > Am Samstag, 15. April 2006 10:10 schrieb Jon Masters:
> > > The attached patch introduces MODULE_FIRMWARE as one way of advertising
>  
> > Strictly speaking, what is the connection with modules? Statically
> 
> The same as MODULE_AUTHOR, MODULE_LICENSE, etc.  The divide is more
> logical than physical.
> 
> > compiled drivers need their firmware, too. Secondly, do all drivers
> > know at compile time which firmware they'll need?
> 
> They have to know what they will request, do they not?


in order to not fall in the naming-policy trap: do we need a translation
layer here? eg the module asks for firmware-<modulename>
and userspace then somehow maps that to a full filename via a lookup
table?


