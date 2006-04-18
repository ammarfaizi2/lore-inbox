Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWDRU0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDRU0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDRU0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:26:44 -0400
Received: from [81.2.110.250] ([81.2.110.250]:34541 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932307AbWDRU0n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:26:43 -0400
Subject: Re: [Fireflier-devel] Re: [RESEND][RFC][PATCH 2/7] implementation
	of LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: fireflier-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>,
       Crispin Cowan <crispin@novell.com>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200604182313.05604.edwin@gurde.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <44453E7B.1090009@novell.com>
	 <1145389813.2976.47.camel@laptopd505.fenrus.org>
	 <200604182313.05604.edwin@gurde.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 18 Apr 2006 21:31:46 +0100
Message-Id: <1145392307.21723.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 23:13 +0300, Török Edwin wrote:
> In the current version we intended to use mountpoint+inode to identify 
> programs. This reduces the potential problems from your list to: fd passing.

Inode numbers are not constant on all file systems unless the file is
currently open. That is a pain in the butt when you want to describe a
file as well but it is how things work out.


