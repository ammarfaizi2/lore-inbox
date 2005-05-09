Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVEIRlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVEIRlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVEIRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:41:10 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50314 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261455AbVEIRk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:40:58 -0400
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@linnovative.dk>
Organization: Linnovative
To: James Morris <jmorris@redhat.com>
Subject: Re: Any work in implementing Secure IPC for Linux?
Date: Mon, 9 May 2005 19:40:21 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505091940.22260.ks@linnovative.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 17:00, James Morris wrote:
> On Mon, 9 May 2005, Kristian Sørensen wrote:
> > Does anyone here know of work being done in order to implement secure IPC
> > for Linux?
>
> What do you mean by secure IPC?
As I understand it, presently the memory for the message queue is shared based 
on user and group ownership of the process. By "secure IPC" is meaning a 
security mechanism that provides a more fine granularity of specifying who 
are allowed to send (or receive) messages... and maby also a way to resolve 
the question of "Can I trust the message I received?"


-- 
Kristian Sørensen
  The Umbrella Project  --  Security for Consumer Electronics
  Linnovative  --  www.linnovative.dk
  ks@linnovative.dk  --  +45 2972 3816
