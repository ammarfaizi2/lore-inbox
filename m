Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVCKMfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVCKMfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVCKMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:35:37 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:23993 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262687AbVCKMfM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:35:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R0a0cZaykIKiEJZdp2Fou/CsJsAEouh0w86+OxPscWhK6OvOlxNJEkpDjogb1HRUlJPaw0K6xn5Gce/mkGTOI7uEeG3W7mr71yFpuzFa8gq1LJDmGkTCQXndV2cB/WS/PQVqVdJ8AIGFs1gGHZrqM3lsigeBosmJjVpIN2K+HgY=
Message-ID: <2cd57c90050311043542e55824@mail.gmail.com>
Date: Fri, 11 Mar 2005 20:35:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
Cc: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1110470935.6291.105.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <1110464202.9190.7.camel@localhost.localdomain>
	 <1110464782.6291.95.camel@laptopd505.fenrus.org>
	 <1110468517.9190.24.camel@localhost.localdomain>
	 <1110469087.6291.103.camel@laptopd505.fenrus.org>
	 <1110470430.9190.33.camel@localhost.localdomain>
	 <1110470935.6291.105.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 17:08:55 +0100, Arjan van de Ven
<arjan@infradead.org> wrote:
> On Thu, 2005-03-10 at 17:00 +0100, Lorenzo Hernández García-Hierro
> wrote: it tries to fill the
> > ipaddr member of the task_struct structure with the IP address
> > associated to the user running @current task/process,if available.
> 
> but... a use doesn't hane an IP. a host does.
> 

The patch is useful in this situation. Suppose node E has two IPs, IP1
and IP2. IP1 is the default and got blocked from some network C.

Now if one try to visit C from E, one has to to use IP2.

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
