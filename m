Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbULUPtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbULUPtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 10:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbULUPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 10:49:08 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:34458 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261773AbULUPtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 10:49:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=IOvYvXL4r5PfgVuMrGYRnC4yJCx9g5ucv6A3OcVXHVs2gCM1QfcjIJLc7XKGsEu8H4eK8S+6TX+1e/nCLSjIgnUdJoC4CGmu0ZbDSbtoNJltDNABmo4cGn4aPAllxdg3d2Vl4qWc6ky/dVEF9tXgEGqGPAATv+W3uUaIpvA/efw=
Message-ID: <7d92433304122107491b8b624a@mail.gmail.com>
Date: Tue, 21 Dec 2004 10:49:04 -0500
From: Dan Sturtevant <sturtx@gmail.com>
Reply-To: Dan Sturtevant <sturtx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: fork/clone external to a process?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any clean way to fork a process from outside the process itself?

I'm running a commercial application that I only have a binary copy
of.  All the usual Posix fork stuff only works from inside the running
process.

Is there any reason it's not possible to do so?  Obviously threading
and file desciptors open a whole can of worms, but in the base case,
is it possible?

Thanks in advance, and sorry if it's a stupid question.

Dan Sturtevant
