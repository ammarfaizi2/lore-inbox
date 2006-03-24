Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWCXOOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWCXOOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWCXOOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:14:19 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:31051 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932641AbWCXOOS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:14:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RKsj6/fQMNUhPAle+ycAV4Vj8lUmAMxE6NDjsTM5hj93R5AqdtaTi6bRfSahEqDmfh6VspYf4oPUZXZ41ZpbdZlMDVjB80DShe1yaNtAOO9AS9sv9q5vNg0yDTL6l9wtrchSvTb4WSnB/obO42WGT6Ml0mb7NPwc2D+hCXiP2fY=
Message-ID: <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
Date: Fri, 24 Mar 2006 22:14:17 +0800
From: yang.y.yi@gmail.com
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Connector: Filesystem Events Connector v3
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       johnpol@2ka.mipt.ru, matthltc@us.ibm.com
In-Reply-To: <20060323.230649.11516073.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, David S. Miller <davem@davemloft.net> wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> Date: Fri, 24 Mar 2006 07:59:01 +0100
>
> > then make the syslog part optional.. if it's not already!
>
> Regardless I still think the filesystem events connector is a useful
> facility.
>
> Audit just has way too much crap in it, and it's so much nicer to have
> tiny modules that are optimized for specific areas of activity over
> something like audit that tries to do everything.
>
the filesystem events connector is small and has low overhead, it only
focuses on
 activities in the filesystem, so I think it should be an option for
those users which just concerns events in the filesystem. audit dose
do this, but it is complicated and overhead is big, I believe the
filesystem events connector is useful, but it maybe need to be
improved further.
