Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTLMTeO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTLMTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:34:13 -0500
Received: from holomorphy.com ([199.26.172.102]:33154 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265295AbTLMTeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:34:11 -0500
Date: Sat, 13 Dec 2003 11:30:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "(-> surya <-) " <surya_prabhakar@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: In fs/proc/array.c error in function proc_pid_stat
Message-ID: <20031213193040.GD11665@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"(-> surya <-) " <surya_prabhakar@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20031213192516.4897.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213192516.4897.qmail@linuxmail.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 12:25:15AM +0500, (-> surya <-)  wrote:
>    Thx for the reply . Anyway I patched array.c with this patch(available in the lists posted by Marco Roeland )  , it was working fine .
> rgds
> surya

A quick reading of the patch (BTW, your MUA is mangling whitespace)
reveals it's merely creating a local variable, which should have no
bearing on code generation.

i.e. the compiler is broken.

Bad code generation can cause runtime problems too; upgrading to a
bugfixed compiler is the only sound course of action.


-- wli
