Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270013AbUJHPiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbUJHPiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJHPiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:38:03 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:1981 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270013AbUJHPhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:37:52 -0400
Subject: Re: how do you call userspace syscalls (e.g. sys_rename)
	from	inside kernel
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Brice.Goglin@ens-lyon.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41669844.1070907@ens-lyon.fr>
References: <20041008130442.GE5551@lkcl.net>
	 <1097240824.4389.26.camel@lfs.barra.bali>  <41669844.1070907@ens-lyon.fr>
Content-Type: text/plain; charset=iso-8859-1
Date: Fri, 08 Oct 2004 12:04:50 -0300
Message-Id: <1097247890.5766.3.camel@lfs.barra.bali>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:38 +0200, Brice Goglin wrote:
> > For every sys_xx there is a do_xx, that can
> > be called from inside the kernel.
> 
> Well, not every sys_xx, but most of them :)

yes, you're right. ptrace() is another example.
Too quick of an answer from may part  ;)


> For example there's no do_epoll_ctl for sys_epoll_ctl.
> I requested this one a long time ago but didn't get it.
> 
> Regards,
> 
> Brice Goglin
> ================================================
> Ph.D Student
> Laboratoire de l'Informatique et du Parallélisme
> CNRS-ENS Lyon-INRIA-UCB Lyon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

