Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWGXUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWGXUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWGXUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:17:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:50662 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751435AbWGXUR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:17:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Un/aXhUc2NrbpRDKnHBdMWekT9SkpIzxChlz1+OZOWVxABJNQuVZo9HcUnLoKV8UDGZr/r5LIwnCTYsC0jJqJ9Y3N25kkkxH7vFqoPJOQj+wiG+6s/1QmdPii590093/n7xcP/hUmX3AZS1fEw02QfJiEZPI9ZS613Ks+OWLuzk=
Date: Mon, 24 Jul 2006 22:17:11 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: c-otto@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: NFS errors
Message-ID: <priv$8d118c145696$638ed99e23@200607.chexum.gmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	c-otto@gmx.de, linux-kernel@vger.kernel.org
References: <20060724191540.GD19902@server.c-otto.de> <1153770408.5723.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153770408.5723.4.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2006-07-24 at 15:46:48, Trond Myklebust wrote:
> Have you set 'no_subtree_check' in your export options on the server? If
> not, please try doing so.

Oh.  But Neil almost told me that :)  That seems to fix a similar
problem for me at least:

http://thread.gmane.org/gmane.linux.kernel/426931

Now I'm not seeing any weirdness between two 2.6.18-rc2 hosts.  (No
spurious "Reducing readahead size to 28/4/0K" either).  I still don't
get how that patch that Neil mentioned did not affect 2.6.17 (which had
that), but does effect any 2.6.18-rcX.

Janos
