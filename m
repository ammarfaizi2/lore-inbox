Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUFVRiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUFVRiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUFVRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:06:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264229AbUFVQn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:43:26 -0400
Date: Tue, 22 Jun 2004 12:43:02 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Joy Latten <latten@austin.ibm.com>, <kartik_me@hotmail.com>,
       <linux-kernel@vger.kernel.org>, <serue@us.ibm.com>, <arjanv@redhat.com>,
       <jamesm@redhat.com>
Subject: Re: RSA [patch #1]
In-Reply-To: <14892.1087920395@redhat.com>
Message-ID: <Xine.LNX.4.44.0406221228310.28581-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, David Howells wrote:

>  (3) A DSA signature checker.
> 
> In patch #3, ksign-publickey.c contains a keyring containing some public
> keys. These are listed during boot:
> 
> 	ksign: Installing public key data
> 	Loading keyring
> 	- Added public key 5B23D93E238D57CC
> 	- User ID: David W Howells (hello) <dhowells@redhat.com>
> 	- Added public key 8491D58C6C10A25E
> 	- User ID: David Howells (dwh's signature) <dhowells@redhat.com>

I think the way to manage keyrings is via a filesystem API, which 
different asymmetric crypto apps can register with.


- James
-- 
James Morris
<jmorris@redhat.com>




