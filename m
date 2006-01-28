Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWA1Mgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWA1Mgo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 07:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWA1Mgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 07:36:44 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:58154 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751365AbWA1Mgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 07:36:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RnQAoaPbzxVaSYCcXbO6InB43KBTTZNKTw3j2bjdKLullJsVXHIIA6fLjX//PZpEsCALsX5CPOpEII40DVxSWPmuNkQNdqj3ZE2Y8LV0BAkTdVJ0za/DH7AyPTQbU7dQhkynYNAAtO3I1IyLwEe60MRV6RBMk1txMmfECcgrdKk=
Message-ID: <84144f020601280436l7beafea9x6265b749d94ce593@mail.gmail.com>
Date: Sat, 28 Jan 2006 14:36:39 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Libata, bug 5700.
Cc: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+bpsk@trn.iki.fi>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1138451090.2993.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DB5BE5.8050900@trn.iki.fi>
	 <1138451090.2993.14.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/06, Arjan van de Ven <arjan@infradead.org> wrote:
> Maybe think about if there's more information you can supply to make it
> easier for the developers to diagnose (this is the most common reason
> bugs aren't looked at, just plain not enough info to even begin thinking
> about it)... or look at the code yourself, or try to find where this
> behavior started, or .. or ...

The simplest thing you can do on your own is to see if you can find an
older kernel that doesn't have that problem. And if you do find a
working kernel, you can use git bisect to find out the exact changeset
that broke it. See the following URL for details:
http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

                               Pekka
