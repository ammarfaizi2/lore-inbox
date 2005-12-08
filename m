Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLHOLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLHOLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVLHOLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:11:32 -0500
Received: from iona.labri.fr ([147.210.8.143]:8146 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932121AbVLHOLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:11:31 -0500
Message-ID: <43983EBE.2080604@labri.fr>
Date: Thu, 08 Dec 2005 15:10:06 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: How to enable/disable security features on mmap() ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For educational purpose (I'm teaching software security) I would like to
be able to compile several kernels with or without features such as:

* Non-executable stack
* Stack address randomization
* Environment address randomization (char **envp)
* Dynamic library randomization (cat /proc/self/map)

The idea is to run these kernels in UML mode in order for the students
to complete their exercises and to raise the security level as long as
the course is going further.

Just right now I'm using old versions of Distributions and this is not
really satisfactory (because the compilers have evolved).

So, is there a way to do such thing easily, or should I write patches by
myself ?

Regards
-- 
Emmanuel Fleury

<Sonium> someone speak python here?
<lucky>  HHHHHSSSSSHSSS
<lucky>  SSSSS
<Sonium> the programming language
  -- http://bash.org/
