Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWGIIpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWGIIpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 04:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWGIIpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 04:45:16 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:35098 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932412AbWGIIpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 04:45:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DNqm6UgnMVH4TXIfWMlPcj158i6cdsEvSkjIqJxih6CUTHmqZ6L0rTHBzDBN3LqiGDjS96753n/nXXYKbvnxVWW9VGHjdjtEDB/1apVznDFSbO0vk2nQM6kcODRR9mUEA1eAd/1WyYVKzLsjn4WcfEoUf2AJGBW1bw1MOFtTqEs=
Message-ID: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
Date: Sun, 9 Jul 2006 04:45:14 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Automatic Kernel Bug Report
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well this probably was already discussed. Some distros have automatic
bug reporting tools that are triggered when something bad happens
(don't know if includes kernel stuff). But have anybody thought about
some kind of bug report tool that, under an Oops like a NULL point
dereference, it creates for example a packed file with the config used
to build the kernel, the kernel version, loaded modules, some hardware
info, backtraces, everything that could be useful for debugging, and
sends to a server to be catalogued ?

I know for sure that a lot of people don't use to send bug reports,
either because they are in a hurry and forget, or because they just
don't know how or that it even exists. We could have something that,
under certain bad events, sends that info to a userspace program and
lets it handle that bug report problem automatically (here distros can
be creative).

I'm not sure about including this on distro's kernels, since they
already use some kind of bug report mechanism, and usually distro
kernels are very different from the vanilla one, which could make it
harder to debug the problem. So, distros should ship their kernels
with this thing disabled (or enabled, but having the handler on
userspace pointing to them, and not for us).


Wouldn't that be helpful ?

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
