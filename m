Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWFJXWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWFJXWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWFJXWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:22:48 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:5522 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932255AbWFJXWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=GirmRjrVV3kOaCQxRFRO290B3UtA6aUtqqwC2HSe1Z9LOQiM3dbjMHgxV76JCrBhR2xfsmDxDGOqWJYJzdDWCKAZ8anvGsyqzQp4PlhrWMwTFxlJNkFuqOoaA8Zm4oj1u50FAKr81FVVNqWd1ArP7Ef630BrW1BTIl+rDTlN/JY=
Message-ID: <448B5449.2030605@gmail.com>
Date: Sat, 10 Jun 2006 19:22:49 -0400
From: Anne Thrax <foobarfoobarfoobar@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com
Subject: Removal of security/root_plug.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Apparently security/root_plug.c was written for a Linux Journal article,
and while it does do a good job of explaining LSM, I don't see much use for
it in the mainstream kernel. I suggest that it be removed, because I don't
think that it serves much purpose. I doubt that anyone actually uses this,
for if they did, I think that it would be modified and have many additions.
Even the author states that it is just a starting point. Maybe the article
(if Linux Journal is okay with it) along with the code should be moved to
Documentation/?
