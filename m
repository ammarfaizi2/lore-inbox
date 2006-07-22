Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWGVA56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWGVA56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGVA56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:57:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63301 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750912AbWGVA55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:57:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VszjpV2WnotLpWbE4Xtwnms/A5d3BSGusyxqnACIRe7f5Vk6P+qCsm5kLFKNKhOu6OWZhzFdOC5dd0uXU0NBbcQLU5xUba7LwGT9jTq0h0DwJSHoD7D46YGTRIXIloOO1zwQEjUD4KQ4+gMqgIvUiVAUs5EXpjqABeenmhwc6ww=
Message-ID: <9c21eeae0607211757p6a256b47w5169ecb3f7dbd5b3@mail.gmail.com>
Date: Fri, 21 Jul 2006 17:57:56 -0700
From: "David Brown" <dmlb2000@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Directory Overlay of Root
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to figure out how to do these series of tests against
my system, they involve file access, modification, creation, deletion,
etc. The tests can't be split up to only run against particular
sub-directories of /. I would rather not risk running these tests on
my system unprotected. I've investigated using unionfs but it won't
let me union / with a subdirectory. I've also looked into installwatch
but it will only show what's been touched after the fact.  Also
there's quite a bit of data in lots of small files so copying
everything then doing a chroot is also out of the question. Any
suggestions as to what to use and how I can go about performing these
tests would be useful.

- David Brown
