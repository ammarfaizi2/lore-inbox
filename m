Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVCJQZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVCJQZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVCJQXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:23:14 -0500
Received: from stingr.net ([212.193.32.15]:14782 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S262713AbVCJQT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:19:26 -0500
Date: Thu, 10 Mar 2005 19:19:09 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lorenzo =?utf8?Q?Hern=C3=A1ndez_Garc=C3=ADa-Hierro?= 
	<lorenzo@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
Message-ID: <20050310161909.GD26532@stingr.stingr.net>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lorenzo =?utf8?Q?Hern=C3=A1ndez_Garc=C3=ADa-Hierro?= <lorenzo@gnu.org>,
	linux-kernel@vger.kernel.org
References: <1110464202.9190.7.camel@localhost.localdomain> <1110464782.6291.95.camel@laptopd505.fenrus.org> <1110468517.9190.24.camel@localhost.localdomain> <1110469087.6291.103.camel@laptopd505.fenrus.org> <1110470430.9190.33.camel@localhost.localdomain> <1110470935.6291.105.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1110470935.6291.105.camel@laptopd505.fenrus.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Arjan van de Ven:
> On Thu, 2005-03-10 at 17:00 +0100, Lorenzo Hernández García-Hierro
> wrote: it tries to fill the
> > ipaddr member of the task_struct structure with the IP address
> > associated to the user running @current task/process,if available.
> 
> but... a use doesn't hane an IP. a host does.

I don't get it too
With multihomed setup same process I have can send and receive on many
addresses simultaneously. So single ip_addr cannot describe this
situation.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
