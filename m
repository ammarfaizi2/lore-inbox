Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWEDPXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWEDPXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWEDPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:23:04 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53470 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751502AbWEDPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:23:01 -0400
Subject: Re: [PATCH 5/13: eCryptfs] Header declarations
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <445A16B1.8080407@oktetlabs.ru>
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033750.GD28613@hellewell.homeip.net>
	 <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
	 <445A16B1.8080407@oktetlabs.ru>
Date: Thu, 04 May 2006 18:22:58 +0300
Message-Id: <1146756179.11422.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> > So, what's wrong with BUG_ON?

On Thu, 2006-05-04 at 18:58 +0400, Artem B. Bityutskiy wrote:
> I guess because this may be compiled off when no debugging/extra 
> checking is needed.

But you shouldn't write assertions that you don't really need anyway.

				Pekka

