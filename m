Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBRSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBRSLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWBRSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:11:37 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:59916 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbWBRSLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:11:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZQipNNDUS+yfgLohtHGOeJL8qRinLXWrHF15gqQQddp9VCLUymYV/JkGpt/R+jj3OVbUf+mibTwEg3ysNKaFVa7ZiVF4fDLepQGvp/oepCRdsLhU5jzk5f0F3f6zoLgZYX+1eXUthQN4uTF4fanFI75TaG6wYIpazFLXU3Xl0Jk=
Date: Sat, 18 Feb 2006 16:11:22 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, dhowells@redhat.com, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl)
Message-Id: <20060218161122.f9d588fb.davi.arnaut@gmail.com>
In-Reply-To: <3487.1140281089@warthog.cambridge.redhat.com>
References: <20060218113602.edc06ce5.davi.arnaut@gmail.com>
	<3487.1140281089@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006 16:44:49 +0000
David Howells <dhowells@redhat.com> wrote:

> 
> Davi Arnaut <davi.arnaut@gmail.com> wrote:
> 
> > Convert security/keys/keyctl.c string duplication to strdup_user()
> 
> Can you redo this on top of hose patches I submitted yesterday please?
> 
> David

I think you should just tell Andrew to drop
keys-deal-properly-with-strnlen_user.patch
in favor of mine... :-)

--
Davi Arnaut
