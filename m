Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVDRUBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVDRUBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVDRUBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:01:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262191AbVDRUBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:01:39 -0400
Date: Mon, 18 Apr 2005 16:01:22 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] procfs privacy
In-Reply-To: <1113853561.17341.111.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504181600480.11251@chimarrao.boston.redhat.com>
References: <1113849977.17341.68.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0504181526280.11251@chimarrao.boston.redhat.com>
 <1113853561.17341.111.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279726928-174483625-1113854482=:11251"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279726928-174483625-1113854482=:11251
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 18 Apr 2005, Lorenzo Hernández García-Hierro wrote:

> Adding a "trusted user group"-like configuration option could be useful,
> as it's done within grsecurity, among that the whole thing might be good
> to depend on a config. option, but that implies using weird ifdef's and
> the other folks.

I'd rather see something like this implemented as an LSM
module - or better yet, an SELinux security policy.

There's no need to sprinkle security policy all over the
kernel.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
--279726928-174483625-1113854482=:11251--
