Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbSIPWsJ>; Mon, 16 Sep 2002 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbSIPWsI>; Mon, 16 Sep 2002 18:48:08 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:14322 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263254AbSIPWsH>; Mon, 16 Sep 2002 18:48:07 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020916.142931.126209536.davem@redhat.com> 
References: <20020916.142931.126209536.davem@redhat.com>  <20020916.125211.82482173.davem@redhat.com> <Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, netdev@oss.sgi.com, pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 23:53:00 +0100
Message-ID: <12116.1032216780@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>    new system calls into the networking code
> The system calls would go into the VFS, sys_receivefile is not
> networking specific in any way shape or form. 

Er, surely the same goes for sys_sendfile? Why have a new system call 
rather than just swapping the 'in' and 'out' fds?

--
dwmw2


