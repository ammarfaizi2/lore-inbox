Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbUKVSvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUKVSvl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUKVSvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:51:40 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15580 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262229AbUKVSs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:48:58 -0500
Message-ID: <41A23496.505@namesys.com>
Date: Mon, 22 Nov 2004 10:48:54 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: Helge Hafting <helge.hafting@hist.no>, Amit Gud <amitgud1@gmail.com>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
In-Reply-To: <41A21EAA.2090603@dbservice.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:

> Helge Hafting wrote:
>
>> I recommend looking at archived threads about file as directory,
>> you'll find many more arguments.  Currently there is one kind
>> of support for archive files - loop mounts over files containing
>> filesystem images.  These are not compressed though.
>
>
> Isn't reiserfs trying to implement such things? I've read that in some 
> next version of reiserfs one will be able to open 
> /etc/passwd/[username]  and get the informations about [username], 
> like UID, GID, home directory etc.


>
> Still true? And when can we except such a version of reiserfs?
>
> tom
>
>
It was more that we said we would like to implement the functionality 
necessary for doing that (e.g. inheritance), not that we would 
specifically do /etc/passwd.  And that functionality will trickle in 
over time.

Hans
