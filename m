Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSFYXQ5>; Tue, 25 Jun 2002 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSFYXQ5>; Tue, 25 Jun 2002 19:16:57 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:52868 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S316047AbSFYXQ4>;
	Tue, 25 Jun 2002 19:16:56 -0400
Date: Tue, 25 Jun 2002 19:16:58 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: EXPORT_SYMTAB, or Is "this_object_must_be_defined_as_export_objs_in_the_Makefile"
 annoying to anyone?
Message-ID: <Pine.LNX.4.33L2.0206251914230.28225-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am not sure for the reasoning behind it, but it seems that newer 2.4
kernels require the additional -DEXPORT_SYMTAB be defined for any code one
wants to build as a module (if that module exports symbols).  Needless to
say this breaks a lot of (non-kernel-tree) modules that would otherwise
have been compiling without problems.

What is the rationale behind this?

-Calin

