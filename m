Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUFVTio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUFVTio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265672AbUFVTeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:34:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265110AbUFVSI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:08:26 -0400
Date: Tue, 22 Jun 2004 14:08:08 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Joy Latten <latten@austin.ibm.com>, <kartik_me@hotmail.com>,
       <linux-kernel@vger.kernel.org>, <serue@us.ibm.com>, <arjanv@redhat.com>
Subject: Re: RSA [patch #1] 
In-Reply-To: <18339.1087923439@redhat.com>
Message-ID: <Xine.LNX.4.44.0406221403100.28926-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, David Howells wrote:

> 
> > I think the way to manage keyrings is via a filesystem API, which 
> > different asymmetric crypto apps can register with.
> 
> I'm not sure what you're thinking of exactly. Can you elaborate?

Different kernel asymmetric crypto apps (e.g. module signature checker)  
will need to be able to manage independent keyrings, and a common
filesystem API would be useful for this.  e.g. during startup, some init 
script loads keyrings into the kernel via /proc/crypto/keyring/app/addkey


- James
-- 
James Morris
<jmorris@redhat.com>


