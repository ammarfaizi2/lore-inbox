Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUBWTNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUBWTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:13:04 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:51934 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261898AbUBWTNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:13:02 -0500
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <015e01c3fa01$346bb0d0$34ee4ca5@DIAMONDLX60>
From: Junio C Hamano <junkio@cox.net>
Date: Mon, 23 Feb 2004 11:13:00 -0800
In-Reply-To: <fa.ip45pqg.i26oru@ifi.uio.no> (Norman Diamond's message of
 "Mon, 23 Feb 2004 11:41:07 GMT")
Message-ID: <7v7jydr4n7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "ND" == Norman Diamond <ndiamond@wta.att.ne.jp> writes:

ND> Eric W. Biederman wrote:
>> Even X cut and paste frequently abuses the iso8859-1 range,

ND> I'll take your word for it.  I've copied and pasted EUC
ND> strings, I've copied and pasted SJIS strings, I don't know
ND> if X copy and paste abused EUC or SJIS ranges, but it
ND> worked.

I do not know what Eric means by "abusing the iso8859-1 rnge",
but passing X selection between traditional X clients IIRC uses
compound text, which is an encoding vaguely similar to ISO-2022,
so clients like kterm can convert it back and forth with EUC or
SJIS as needed.

