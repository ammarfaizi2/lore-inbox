Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbUAMNfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUAMNfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 08:35:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38892 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264289AbUAMNfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 08:35:11 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 13 Jan 2004 14:35:03 +0100 (MET)
Message-Id: <UTC200401131335.i0DDZ3J17112.aeb@smtp.cwi.nl>
To: andries.brouwer@cwi.nl, jasper@vs19.net, torvalds@osdl.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Change all occurences of flavour to flavor

s/r/rr/

> I've just comiled all affected files

...

> Andries, I did a small check if mount uses the fieldnames frrom the kernel
> headers, which doesn't seem to be the case, can you confirm that this?

The theory still is that user space must not include kernel headers,
so even if mount used some include this is not an objection.

On the other hand, I am not quite sure why one would do this.
Fixing typos I like - occurences should be occurrences and comiled compiled -
but fixing something that is correct in English because it is wrong in American?
There are occasional words in Polish, Danish, French, German in the kernel.
I wouldn't mind some words in English.

Andries
