Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTKTRZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTKTRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:25:48 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:17337 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262796AbTKTRZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:25:39 -0500
From: Shaheed <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Date: Thu, 20 Nov 2003 17:26:48 +0000
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311201726.48097.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> B) A heuristic that looks at the mounted block devices for things that smell 
> like a resume partition would actually be more robust in that case.

How about a static signature followed by a timestamp? That way, maybe we could 
have a resume menu like this:

/dev/hda3  (kernel 2.7.88, suspended on 01-04-2004 20:00:00)
/dev/hda4  (kernel 2.8.99, suspended on 31-05-2005 20:00:00) ***
Resume in 5..4..3..2..1..

with a 5 second countdown before it chooses the most recent? Or in Pavel's 
examples:

Erk! Nowhere to resume from! 

:-)
