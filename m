Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132861AbRDQVXm>; Tue, 17 Apr 2001 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132863AbRDQVXc>; Tue, 17 Apr 2001 17:23:32 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:65042 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132861AbRDQVXR>; Tue, 17 Apr 2001 17:23:17 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
Reply-To: WRohdewald@dplanet.ch
To: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Date: Tue, 17 Apr 2001 23:22:47 +0200
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <20010417161036.A21620@bastard.inflicted.net> <20010417223636.C2167@informatics.muni.cz>
In-Reply-To: <20010417223636.C2167@informatics.muni.cz>
Cc: Jan Kasprzak <kas@informatics.muni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010417212249.D0552C24B@poboxes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2001 22:36, Jan Kasprzak wrote:
> +    if (len == -1 || len > 0 && len < count) {

are you sure there are no missing () ?

if ((len == -1) || (len > 0) && (len < count)) {

assumig that && has precedence over || (I believe so)
