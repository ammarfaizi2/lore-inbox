Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVKRQvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVKRQvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKRQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:51:44 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:1862 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964792AbVKRQvo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:51:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cvocgOcwt+m9lnyMshyw0l1FE2hOPhA9p4dB5uK9YfXHAjR/NaQH3d1lXUJzuDtIx+soUtMG3dy/eWqBhMWnZ38EIlL7Oj1xj78sT+02TRous82QJeZ/mWzBl3Q7iWFP7hUaUuJSkdjMyHAyBlH+Ala/h6sq6xKTOwfC5GMZUJY=
Message-ID: <fb7befa20511180851i70e1017cp423db24d7d561082@mail.gmail.com>
Date: Fri, 18 Nov 2005 11:51:41 -0500
From: Adayadil Thomas <adayadil.thomas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Conntrack helper modules ( 2.6.9 vs 2.6.12)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

The place where the connection tracking helper modules are called from changed
from 2.6.9 to 2.6.12.

In 2.6.9, helper modules were called from ip_conntrack_core.c (
ip_conntrack_in function)

In 2.6.12, the helper modules are called from
ip_conntrack_standalone.c (ip_conntrack_help funtion)


I would like to use the 2.6.12 kernel, but with helper modules called
like in 2.6.9

I was wondering if other parts of the system would be affetcted if I
put the helper module call in
ip_conntrack_in and remove the call from ip_conntrack_help


Any help or information is greatly appreciated.

Thanks a lot,
Thomas
