Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTEMQbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEMQbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:31:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44444
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261564AbTEMQaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:30:12 -0400
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
In-Reply-To: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 16:44:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 16:52, Linus Torvalds wrote:
> I think the code looks pretty horrible, but I think we'll need something
> like this to keep track of keys. However, I'm not sure we should make this
> a new structure - I think we should make the current "tsk->user" thing
> _be_ the "PAG". 

With something like SELinux a PAG may belong to a role not to a user
even though other limits like processes probably belong to the user as a
whole. 

How does AFS currently handle this, can two logins of the same user have
seperate PAGs ?

